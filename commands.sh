# Define the server for uploading files
COMPUTER_ART_CURL_TARGET=""

# Upload a file to the server
function upload() {
    # Check if file is specified
    if [ -z "$1" ]; then
        # Log error if file is not specified
        >&2 echo "ERROR: Please specify a file to upload: upload <path_to_file>"
        # Return error code 2
        return 2
    fi

    # Check if one file specified only
    if [ "$#" -ne 1 ]; then
        # Log error if more than one file specified
        >&2 echo "ERROR: Please specify one file to upload only: upload <path_to_file>"
        # Return error code 2
        return 2
    fi

    # Check if specified file exists
    if [ -f "$1" ]; then
        # Upload file to the server if it exists

        # Get current timestamp
        timestamp=$(date +%s%N)

        # Get base name of file with extension
        filename=$(basename -- "$1")
        # Get extension of file
        extension="${filename##*.}"
        # Get name of file without extension
        filename="${filename%.*}"

        # Construct target file name on the server
        target_name=$filename-$timestamp.$extension

        # Log info about uploading
        echo "Uploading the file '$1' to the server as '$target_name'..."
        # Upload file
        curl -X POST -H "Content-Type: multipart/form-data" -F "image=@$1" -F "name=$target_name" $COMPUTER_ART_CURL_TARGET
    else
        # Log error if specified file does not exist
        >&2 echo "The file '$1' does not exist."
        # Return error code 2
        return 2
    fi
}

# Run a Ruby script
function run() {
    # Check if script is specified
    if [ -z "$1" ]; then
        # Log error if script is not specified
        >&2 echo "ERROR: Please specify a script to run: run <path_to_script>"
        # Return error code 2
        return 2
    fi

    # Check if one script specified only
    if [ "$#" -ne 1 ]; then
        # Log error if more than one script specified
        >&2 echo "ERROR: Please specify one script to run only: run <path_to_script>"
        # Return error code 2
        return 2
    fi

    # Check if specified script exists
    if [ -f "$1" ]; then
        # Run script if it exists

        # Log info about running
        echo "Running the script '$1'..."
        # Run script
        ruby $1
    else
        # Log error if specified script does not exist
        >&2 echo "The script '$1' does not exist."
        # Return error code 2
        return 2
    fi
}

# Force removal of SVG files in the current directory
function svgclean() {
    # Log info about cleaning
    echo "Cleaning SVG files in the current directory..."
    # Force remove all SVG files in the current directory
    rm -rf *.svg
}

# Remove all defined functions from terminal
function unsource() {
    # Remove upload function
    unset upload
    # Remove run function
    unset run
    # Remove svgclean function
    unset svgclean
    # Remove unsource function
    unset unsource
}