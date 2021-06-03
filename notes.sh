cp -r ./package/* ./
npm install
npm run build

grep --perl-regexp /if\s*\(tracker\)\s*\{(.*)\}\n\s*\}[\n]{1,2}\s*_markKeyChanged/gim ./package/lib/ValidationContext.js
find ./package/lib/ValidationContext.js -type f -exec sed -i 's/if\s*\(tracker\)\s*\{([.\n\r\s\w\d_\-\=\(\)\{\};\[\]>]*)\n\s*_markKeyChanged/xxx/g' {} \;

grep -rl ValidationContext.js ./lib/ | xargs sed -i 's/if\s*\(tracker\)\s*\{([.\n\r\s\w\d_\-\=\(\)\{\};\[\]>]*)\n\s*_markKeyChanged/string2/g'
grep -rl '/if \(trackerif\) {([.\n\r\s\w\d_\-\=\(\){};\[\]>]*)\n\s*_markKeyChanged/' ./lib/ | xargs sed -i 's/if \(tracker\) {([.\n\r\s\w\d_\-\=\(\){};\[\]>]*)\n\s*_markKeyChanged/linux/g'
grep -rlIZPi 'tracker' | xargs -0r perl -pi -e 's/tracker/replace/gi;'

find ./ -type f -iname "*ValidationContext*" -print0 | xargs -0 sed -i '/tracker/s/tracker/linux/gim'


GOOD

find ./ValidationContext.js -type f -print0 | xargs -0 sed -i '/if\s*\(tracker\)\s*\{([.\n\r\s\w\d_\-\=\(\)\{\};\[\]>]*)\n\s*_markKeyChanged/s/if\s*\(tracker\)\s*\{([.\n\r\s\w\d_\-\=\(\)\{\};\[\]>]*)\n\s*_markKeyChanged/linux/g'

find ./lib/ValidationContext.js -type f -print0 | xargs -0 sed -i '/if\s*\(tracker\)\s*\{([.\n\r\s\w\d_\-\=\(\){};\[\]>]*)\n\s*_markKeyChanged/s/if\s*\(tracker\)\s*\{([.\n\r\s\w\d_\-\=\(\){};\[\]>]*)\n\s*_markKeyChanged/banana/g'

grep -n 'tracker' ./lib/ValidationContext.js | cut -d: -f 1

START_CUT_LINE_NUMBER=$(grep -n 'if (tracker) {' ./lib/ValidationContext.js | cut -d: -f 1)
END_CUT_LINE_NUMBER=$(grep -n '_markKeyChanged(key) {' ./lib/ValidationContext.js | cut -d: -f 1)

for 

# Replace the line of the given line number with the given replacement in the given file.

sed -i '33d' file


function replace-line-in-file() {
    local file="./lib/ValidationContext.js"
    local line_num="$START_CUT_LINE_NUMBER"
    local replacement="$3"

    # Escape backslash, forward slash and ampersand for use as a sed replacement.
    replacement_escaped=$( echo "$replacement" | sed -e 's/[\/&]/\\&/g' )

    sed -i "${line_num}s/.*/$replacement_escaped/" "$file"
}

  
if (tracker) {  