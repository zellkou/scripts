#!/bin/bash
# shellcheck disable=SC2129

#Gobal Variables
#ahref1='<a href="'
#ahref3="$ahref1$i"
#c='"'
#ahref4=$ahref3$c
#ahref5="$ahref4>"
#a="${i%.*}"
#b="$(echo "$a" | sed 's/\./\ /g')";
#ahref2="$ahref5$b</a>"

header() {
  printf '%s\n' "<!doctype html>" "<html>" " <head>" '   <link rel="stylesheet" href="style.css">' >> index.html;
  printf '%s\n' '   <meta charset="UTF-8">' "   <title>The Hillbilly Hacker</title>" >> index.html;
  printf '%s\n' "  </head>" "    <body>"	"      <div>" "        <center>" >> index.html;
	printf '%s\n'	"          <h1> The Hillbilly Hacker Recipes</h1>" "        </center>" >> index.html
	printf '%s\n' "      </div>" "      <div>" "        <center>" "       <h2>Pickles</h2>" "          <p>" >> index.html
}

footer() {
  printf '%s\n' "          </p>" "        </center>" "      </div>" "    </body>" "</html>" >> index.html
}

bread() {
  printf '%s\n' "          </p>" "         <h2>Bread</h2>" "       <p>" >> index.html
}

cd /docker/letsencrypt/config/www/recipes || exit;

rm index.html;

header;

cd pickles || exit;

for i in *.txt;
  do ahref1='<a href="'
     ahref3="$ahref1$i"
     c='"'
     ahref4=$ahref3$c
     ahref5="$ahref4>"
     a="${i%.*}"
     b1="${a/\./ }"
#     b="$(echo "$a" | sed 's/\./\ /g')";
     ahref2="$ahref5$b1</a>"
     printf '%s\n' "            $ahref2" "            <br>" >> ../index.html
done

cd ../;

bread;

cd bread || exit;

for i in *.txt;
  do ahref1='<a href="'
     ahref3="$ahref1$i"
     c='"'
     ahref4=$ahref3$c
     ahref5="$ahref4>"
     a="${i%.*}"
     b1="${a/\./ }"
#     b="$(echo "$a" | sed 's/\./\ /g')";
     ahref2="$ahref5$b1</a>"
     printf '%s\n' "            $ahref2" "            <br>" >> ../index.html
done



footer;
