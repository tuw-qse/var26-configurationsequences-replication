#!/usr/bin/env bash

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
MAGENTA='\e[35m'
CYAN='\e[36m'
WHITE='\e[37m'
BOLD='\e[1m'
RESET='\e[0m'

create_backups_for_jar=false
compile_parser=true
install_parser=true
install_plugins=true

echo "Source repository="$1
echo "Target repository="$2

OWNER="${SUDO_USER:-$(id -un)}"
GROUP="$(id -gn "$OWNER")"

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source-repository> <target-repository>"
    exit 1
fi

# Create backups (use only once)
if [ "$create_backups_for_jar" = true ]; then
    echo -e "${MAGENTA}${BOLD}### Create parser backups.${RESET}"
    cd $1/FeatureIDE
    find -name 'uvl-parser.jar' -exec mv {} {}.old ';'

    cd $2
    find -name 'uvl-parser.jar' -exec mv {} {}.old ';'
fi

# Install the UVL parser to the FeatureIDE
if [ "$compile_parser" = true ]; then
    echo -e "${MAGENTA}${BOLD}### Compile parser grammar.${RESET}"
    cd $1/uvl-parser/
    sudo antlr4 -Dlanguage=Java -o java/src/main/ uvl/UVLJava.g4
    cd ./java/
    echo -e "${MAGENTA}${BOLD}### Assemble parser.${RESET}"
    sudo chown -R "$OWNER:$GROUP" src/main/uvl
    mvn clean compile assembly:single
fi

# Install the parser
if [ "$install_parser" = true ]; then
    uvl_parser_jar="$1/uvl-parser/java/target/uvl-parser-0.3-jar-with-dependencies.jar"
    md5sum $uvl_parser_jar

    cd $1/FeatureIDE
    echo -e "${MAGENTA}${BOLD}### Copy uvl-parser to FeatureIDE source repository.${RESET}"
    find -name 'uvl-parser.jar' -exec cp $uvl_parser_jar {} ';'
    echo -e "${MAGENTA}${BOLD}### Parser checksums in FeatureIDE source repository.${RESET}"
    md5sum $(find . -type f -name "uvl-parser.jar" -print)

    cd $2
    echo -e "${MAGENTA}${BOLD}### Copy uvl-parser to FeatureIDE target repository.${RESET}"
    find -name 'uvl-parser.jar' -exec cp $uvl_parser_jar {} ';'
    echo -e "${MAGENTA}${BOLD}### Parser checksums in FeatureIDE target repository.${RESET}"
    md5sum $(find . -type f -name "uvl-parser.jar" -print)
fi

# Compile the 'FeatureIDE' plugin and install it in FeatureIDE target repository
if [ "$install_plugins" = true ]; then
    cd $1/FeatureIDE
    mvn clean package
    cd $1

    source_code_plugins_dir="$1/FeatureIDE/plugins"
    eclipse_plugins_dir="$2/eclipse/plugins"

    echo -e "${MAGENTA}${BOLD}### Copy parser to FeatureIDE target repository.${RESET}"
    cp "$1/uvl-parser/java/target/uvl-parser-0.3-jar-with-dependencies.jar" "$2/eclipse/configuration/org.eclipse.osgi/620/0/.cp/lib/uvl-parser.jar"

    echo -e "${MAGENTA}${BOLD}### Copy FeatureIDE bundles to FeatureIDE target repository.${RESET}"
    cp "${source_code_plugins_dir}/de.ovgu.featureide.fm.core/target/de.ovgu.featureide.fm.core-3.11.1-SNAPSHOT.jar" \
       "${eclipse_plugins_dir}/de.ovgu.featureide.fm.core_3.11.1.202403121722.jar" \
        && echo "Installed 'featureide.fm.core' in FeatureIDE target repository"

    cp "${source_code_plugins_dir}/de.ovgu.featureide.fm.attributes/target/de.ovgu.featureide.fm.attributes-3.11.1-SNAPSHOT.jar" \
       "${eclipse_plugins_dir}/de.ovgu.featureide.fm.attributes_3.11.1.202403121722.jar" \
        && echo "Installed 'featureide.fm.attributes' in FeatureIDE target repository"

    cp "${source_code_plugins_dir}/de.ovgu.featureide.fm.ui/target/de.ovgu.featureide.fm.ui-3.11.1-SNAPSHOT.jar" \
       "${eclipse_plugins_dir}/de.ovgu.featureide.fm.ui_3.11.1.202403121722.jar" \
        && echo "Installed 'featureide.fm.ui' in FeatureIDE target repository"

    cp "${source_code_plugins_dir}/de.ovgu.featureide.examples/target/de.ovgu.featureide.examples-3.11.1-SNAPSHOT.jar" \
       "${eclipse_plugins_dir}/de.ovgu.featureide.examples_3.11.1.202403121722.jar" \
        && echo "Installed 'featureide.examples' in FeatureIDE target repository"
fi
