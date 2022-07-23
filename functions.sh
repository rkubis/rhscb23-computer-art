# Define URL for Textorizer tool
COMPUTER_ART_TEXTORIZER_URL="https://lapin-bleu.net/software/textorizer/"
# Define URL for Rollage tool
COMPUTER_ART_ROLLAGE_URL="http://rollage.jhd.cz/"
# Define URL for Jackson Pollock tool
COMPUTER_ART_POLLOCK_URL="http://jacksonpollock.org/"
# Define the server for uploading files
COMPUTER_ART_UPLOAD_URL="http://radimkubis.cz/rhscb22/gallery/upload.php"
# Define URL of ASCII to SVG project
COMPUTER_ART_PROJECT_URL="https://github.com/a6b8/ascii-to-svg-generator-for-ruby"

function openurl() {
    # Search for firefox command
    firefox_cmd=$(which firefox 2>/dev/null)

    # Check if firefox command exists
    if [ -z "$firefox_cmd" ]; then
        # Print URL if firefox is not present
        echo "Please go to $1"
    else
        # Open URL in firefox if available
        firefox $1
    fi
}

# Open page with Textorizer online tool
function textorizer() {
    openurl $COMPUTER_ART_TEXTORIZER_URL
}

# Open page with Rollage online tool
function rollage() {
    openurl $COMPUTER_ART_ROLLAGE_URL
}

# Open page with Jackson Pollock online tool
function pollock() {
    openurl $COMPUTER_ART_POLLOCK_URL
}

# Setup environment for class
function setup() {
    # Install ascii_to_svg gem
    gem install ascii_to_svg --user-install
}

# Open page with ASCII to SVG project
function manual() {
   openurl $COMPUTER_ART_PROJECT_URL
}

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
        curl -X POST -H "Content-Type: multipart/form-data" -F "image=@$1" -F "name=$target_name" $COMPUTER_ART_UPLOAD_URL
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
function cleanup() {
    # Log info about cleaning
    echo "Cleaning SVG files in the current directory..."
    # Force remove all SVG files in the current directory
    rm -rf *.svg
}

# Remove all defined functions from terminal
function unsource() {
    # Remove openurl function
    unset openurl
    # Remove textorizer function
    unset textorizer
    # Remove rollage function
    unset rollage
    # Remove pollock function
    unset pollock
    # Remove setup function
    unset setup
    # Remove manual function
    unset manual
    # Remove upload function
    unset upload
    # Remove run function
    unset run
    # Remove cleanup function
    unset cleanup
    # Remove unsource function
    unset unsource
}
