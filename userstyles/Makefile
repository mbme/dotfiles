build:
	scss --sourcemap=none ./solarized.scss ./solarized.css

copy:
	echo "Copying to clipboard..."
	xclip -sel clip < ./solarized.css

all: build copy
