#!/bin/bash

PROGNAME=$(basename $0)
VERSION="1.0"

usage() {
    echo "Usage: $PROGNAME [ options ]  FILE_PATH"
    echo
    echo "Options:"
    echo "  -h, --help"
    echo "  -v  --version"
    echo "  -a, --aspect weight:height        change aspect ratio. default is 16:9."
    echo "  -b, --background #color           decide add color.default is clear."
    echo "  -o, --output PATH                 decide output path. default is same directory with input file."
    echo
    exit 1
}

for OPT in "$@"
do
    case "$OPT" in
        '-h'|'--help' )
            usage
            exit 1
            ;;
        '-v'|'-V'|'--version' )
            echo $VERSION
            exit 1
            ;;
        '-a'|'--aspect' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "--aspect option requires an argument" 1>&2
                exit 1
            fi
            ASPECT=($( echo "$2" | awk -F'[:]' '{print $1,$2}'))
            shift 2
            ;;
        '-b'|'--background' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "--background option requires an argument" 1>&2
                exit
            elif [[ ! "$2" =~ ^# ]]; then
                echo "--background argument starts #(ex. --background #000000)" 1>&2
                exit 1
            fi
            COLOR="$2"
            shift 2
            ;;
        '-o'|'--output' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "--output option requires an argument" 1>&2
                exit 1
            elif [[ ! -d "$2" ]]; then
                echo "--output option value decides only directory" 1>&2
                exit 1
            fi
            OUTDIR="$2"
            shift 2
            ;;
        '--'|'-' )
            shift 1
            param+=( "$@" )
            break
            ;;
        -*)
            echo "$PROGNAME: illegal option -- '$(echo $1 | sed 's/^-*//')'" 1>&2
            exit 1
            ;;
        *)
            if [[ ! -z "$1" ]] && [[ ! "$1" =~ ^-+ ]]; then
                INPUT+=( "$1" )
                shift 1
            fi
            ;;
    esac
done

if [ -z $INPUT ]; then
    echo "$PROGNAME: require image file path" 1>&2
    echo "Try '$PROGNAME --help' for more information." 1>&2
    exit 1
fi


OUTNAME=$(echo `basename $INPUT` | sed -e "s/\./-resize\./g")
OUTDIR=${OUTDIR:=`dirname $INPUT`}
OUTPUT=$OUTDIR/$OUTNAME

if [ -z $ASPECT ]; then
    ASPECT=(16 9)
fi
resolution=($(identify -format '%w %h' $INPUT))
if [ ${resolution[0]} -ge $((${resolution[1]}*${ASPECT[0]}/${ASPECT[1]})) ]; then
    resolution[1]=$((${resolution[0]}*${ASPECT[1]}/${ASPECT[0]}))
else
    resolution[0]=$((${resolution[1]}*${ASPECT[0]}/${ASPECT[1]}))
fi

if [ ! -z $COLOR ]; then
    R_value=$(echo "obase=10; ibase=16; $(echo $COLOR | awk '{print substr($0,2,2)}')"|bc)
    G_value=$(echo "obase=10; ibase=16; $(echo $COLOR | awk '{print substr($0,4,2)}')"|bc)
    B_value=$(echo "obase=10; ibase=16; $(echo $COLOR | awk '{print substr($0,6,2)}')"|bc)
    COLOR="\"rgb($R_value,$G_value,$B_value)\""
else
    COLOR=none
fi
COMMAND="convert $INPUT -background $COLOR -gravity Center -extent ${resolution[0]}x${resolution[1]} $OUTPUT"

$COMMAND
