#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

PLANTUML_HOME="$(dirname $0)/plantuml.jar"

# ==============================================================================
# ------------------------------------------------------------------------------
plantuml() {
    local bShowHelp

    bShowHelp=false

    JAVA_HOME=${JAVA_HOME:-}

    if [ -n "${JAVA_HOME}" ] && [ -x "${JAVA_HOME}/bin/java" ] ; then
        JAVA="${JAVA_HOME}/bin/java"
    elif [ -x /usr/bin/java ] ; then
        JAVA=/usr/bin/java
    else
        echo Cannot find JVM >&2
        exit 1
    fi

    for sParam in "$@";do
        if [ "${sParam}" = "--help" ];then
            bShowHelp=true
        fi
    done

    if [ "${bShowHelp}" = true ] && [  "$#" -ne 4 ];then
        $JAVA -jar ${PLANTUML_HOME} -help
    else
        $JAVA -jar ${PLANTUML_HOME} -failfast2 ${@}
    fi


}
# ==============================================================================


# ==============================================================================
if [ "${0}" = "${BASH_SOURCE}" ];then
    # direct call to file
    plantuml $@
fi # else file is included from another script
# ==============================================================================

#EOF
