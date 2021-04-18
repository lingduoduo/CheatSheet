### [ Shell sed Scripting](https://duoduo2011.blogspot.com/2013/07/basic-linux-shell-sed-scripting.html)

Unix command such as uniq, sort, nl read-in from standard input, transform text and export to standard output. sed and awk also transform text like filter, can be part of a pipeline, are programmable, have their own scripting language to specify transformation rules.

sed supports a number of operations,
s command (stand for substitute) is the one of the most commonly used commands,
d command removes empty lines.

Regular Expressions use to identify patterns, similar as glob expressions. While globs patterns match pathnames, regexes match any general text data. For example, [a-zA-Z0-9] match letters and digits and meta-characters include * . + ? $ | ():
\* represents zero or more place expression,
\+ is a regular expression,
^ anchors the match to the beginning of the record,
$ represents end of the expression.
capture parentheses use \( and /) , and back-reference use \1.
\b is a word boundary,
\w is a single word character,
\b\w\+\b matches a word.

sed 's/a/b/' - s:substitution, a:search string, b:replacement string
Syntax is s/REGEXP/REPLACEMENT/FLAGS.
Examples
echo 'upstream' | sed 's/up/down/' (replace up with down)
echo 'upstream and upward' | sed 's/up/down/' (replace once)
echo 'upstream and upward' | sed 's/up/down/g' (replace globally)
echo 'upstream and upward' | sed 's|up|down|g' (delimiter can be / or | or :)
echo 'Mac OS X/Unix: awesome.' | sed 's|Mac OS X/Unix:|sed is |' (use backslash to escape forward slash)
sed 's/apple/mango/' fruits.txt (replace apple with mango first one each line)
sed 's/apple/mango/g' fruits.txt (replace apple with mango globally)
echo 'During daytime we have sunlight.' | sed 's/day/night/'
echo 'During daytime we have sunlight.' | sed -e 's/day/night/' -e 's/sun/moon/' (add second command by -e, e stands for edits)
echo 'who needs vowels?' |sed 's/[aeiou]/_/g' (substitute aeiou using _)
echo 'who needs vowels?' |sed -E 's/[aeiou]+/_/g' (use extended features)
sed 's/^a/  A/g' fruits.txt (indent apple)
sed 's/^/>  /g' fruits.txt (indent everything)
sed 's/^/>(ctrl+v+Tab)/g' fruits.txt (indent using Tab)
sed -E 's/<[^<>]+>//g' homepage.html (take out html tags)
echo 'daytime' | sed 's/\(...)time/daylight/' (change ...time to daylight)
echo 'daytime' | sed -E 's/(...)time/\1daylight/' (extended replace and reused the matched word)
echo 'Dan Stevens' | sed -E 's/([A-Za-z]+) ([A-Za-z]+)/\2, \1/'(change the order of the first and second words)

\- cat fruits.txt | sed 's/Apple/apple/' (replace Apple with apple)
\- cat fruits.txt | sed 's/Apple/apple/i' (flag to specify case insensitive using /i)
\- cat fruits.txt | sed 's/\(A\)pple/apple' (match partially, either Apple or apple will match)
\- cat fruits.txt | sed 's/\(A\)pple/apple/g' (globally occurrence, match more than one match)
\- cat fruits.txt | sed 's/\(A\)pple/\1pple/g' (globally occurrence, match using back-reference \1)
\- cat fruits.txt | sed 's/\b\(A\)pple\b/\1pple/g' (find word boundary)
\- cat fruits.txt | sed 's/\(\b\w\+\b\) \1/\1/g' (find the repeated word and keep the first one)
\- cat fruits.txt | sed -e '9s/\(A\)pple/apple/g' (execute the s command for only line 9)
\- cat fruits.txt | sed -e '9s/\(A\)pple/apple/g' (execute the s command except for line 9)
\- cat fruits.txt | sed 's/^apple/xx/g' (replace for the beginning of the streams)
\- cat fruits.txt | sed 's/apple$/xx/g' (replace for the end of the streams)
\- cat fruits.txt | sed 's/^$/xx/g' (replace for empty lines)
\- cat fruits.txt | sed 's/^ *$/xx/g'(* represents zero or more places, like the + metacharacter)
\- cat fruits.txt | sed 's/apple | Apple/xx/g'(| represents regex1 or regex2) ??
\- cat fruits.txt | sed {'s/apple/xx/g', 's/Apple/xx/g'} (substitute one by one)  ??
\- cat fruits.txt | sed 'd' (delete the lines)
\- sed -e 's/^-1/0 |f/' |sed -e 's/^+1/1 |f/' (Converts the labels from "-1" to "0" and from "+1" to "1" and put the features into a namespace called "f")
\- sed -e 's/$/ const:.01/' (Adds a constant feature called "const" with value ".01")
\- sed -i '18164755d' data.reduced (delete line  18164755)
\- sed -n '1,1000p' (export first 1000 lines)