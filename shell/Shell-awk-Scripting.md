### [Shell awk Scripting](https://duoduo2011.blogspot.com/2013/07/awk-scripting.html)

**Introduction**
awk is good for processing and summarizing structured data; awk is particularly suited for filtering, summarizing and rearranging data.

\- cat fruits.txt | awk '{ print }' (write all lines to stdout)
\- cat fruits.txt | awk '{ print $1}' (write 1 col of all lines to stdout)
\- cat fruits.txt | awk '{ print $3, $1}' (write 3 col and then 1 col of all lines to stdout)
\- cat fruits.txt | awk '/apple/{print}' (print all lines starting from apple)
\- cat fruits.txt | awk '/^a/{print}' (print all lines starting from a)
\- cat fruits.txt | awk '! /apple/{print}' (print all lines not starting from apple)
\- cat fruits.txt | awk '$1 == "apple" {print}' (print all lines starting from apple)
\- cat numbers.txt | awk '{var1 = $1; var2 = $2; avg = (var1+var2)/2; print avg}'
\- cat numbers.txt | awk 'NR %2 == 0 {print}'

login3 15:50:31 ~ $ cat vartot.awk
BEGIN {
 var1 = 0
 var2 = 0
 var3 = 0
}
{
 var1 += $1
 var2 += $2
 var3 += $3
}
END {
 print var1, var2, var3
}
\- cat numbers.txt | awk -f vartot.awk (write all lines to stdout)

**Patterns and Actions**
Patterns can be any expression that returns a value, including regex and range of the form expr1, expr2.
awk has certain variables such as record separators whose values are dynamically set by awk itself.
awk interprets addresses and actions.
NF: number of fields, using whitespace as separators as default.
NR: number of records, using whitespace as separators as default.
RS: set record separators
FS: set field separators
\- cat numbers.txt | awk 'NR %2 == 0 {print}' (print row lines are even)
\- cat numbers.txt | awk '/^10/, NR %2 == 0 {print}' (/, functions as AND)
\- cat numbers.txt | awk 'BEGIN{ FS = ":"} {print $1}' (print first col given the field seperator is :)
\- cat numbers.txt | awk 'BEGIN{ FS = ":"} NR %2 == 0 {print $1}' (print first col when row lines are even given the field seperator is :)
\- cat numbers.txt | awk 'BEGIN{ RS = "\n\nFrom: " ; FS = "\n"} {print $1}' (print first col given the specified field sepearator and record separator)
\- cat months.txt | awk 'BEGIN{ tot = 0} { tot = tot + $2} NR%12 == 0 {print tot/12; tot = 0}' (monthly avg of second col)
\- echo $((502/12)) ( round it to integer)
\- cat months.txt | awk '{ tot = tot + $2} NR%12 == 0 {print tot/12; tot = 0}' (monthly avg of second col; able to drop initialization of tot)
\- cat annual.awk
{
tot = tot + $2
}
NR%12 == 0 {
print tot/12;
tot = 0
}
\- cat months.txt | awk -f annual.awk (monthly avg of second col; able to drop initialization of tot)

\- match(input_var, regular expression, output_var)
\- gsub(regular expression, streams)
...
match($1, /:(.*),(.*)/*, resultmatch)
gsub(/ +/, " ", resultmatch[1]) (squeeze into one space)
gsub(/ +/, " ", resultmatch[2]) (squeeze into one space)
if (tolower(resultmatch[1]) ~ result) (search for result to lower case of resultmatch col 1)
{
 print $1;
}