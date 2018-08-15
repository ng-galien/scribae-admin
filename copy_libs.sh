#!/bin/bash
echo "...copy_js script from $PWD"
echo "==========================="
echo "Copy js libs"
echo "==========================="
#Install Libraries
echo "Install librairies via npm..."
npm install
#Copy a prototype to a target project with librairies
echo "==========================="
js_target="./app/assets/javascripts/common"
css_target="./app/assets/stylesheets/common"
sass_target="./app/assets/stylesheets"
opts="-vruptog"

#Copy javascript files
echo "==========================="
echo "Copy js librairies..."
echo "==========================="

#jQuery
#echo "==========================="
#echo "Copy jQuery"
#echo "==========================="
#rsync $opts node_modules/jquery/dist/jquery.min.js "$js_target"

#JQuery lazy
echo "==========================="
echo "Copy jQuery lazy"
echo "==========================="
rsync $opts node_modules/jquery-lazy/jquery.lazy.min.js "$js_target"
rsync $opts node_modules/jquery-lazy/jquery.lazy.plugins.min.js "$js_target"

#JQuery minicolors
echo "==========================="
echo "Copy jQuery minicolors"
echo "==========================="
rsync $opts node_modules/jquery-minicolors/jquery.minicolors.min.js "$js_target"
rsync $opts node_modules/jquery-minicolors/jquery.minicolors.css "$css_target"
rsync $opts node_modules/jquery-minicolors/jquery.minicolors.png "./public"

#JQuery matchHeight
echo "==========================="
echo "Copy jQuery matchHeight"
echo "==========================="
rsync $opts node_modules/jquery-match-height/dist/jquery.matchHeight-min.js "$js_target"

#Materialize
echo "==========================="
echo "Copy materialize"
echo "==========================="
rsync $opts node_modules/materialize-css/dist/js/materialize.min.js "$js_target"
rsync $opts node_modules/materialize-css/sass/ "$sass_target"

#Simple MDE
echo "==========================="
echo "Copy simpleMDE"
echo "==========================="
rsync $opts node_modules/simplemde/dist/simplemde.min.js "$js_target"
rsync $opts node_modules/simplemde/dist/simplemde.min.css "$css_target"

#Modernizr
#echo "==========================="
#echo "Compile and copy modernizr"
#echo "==========================="
#./node_modules/modernizr/bin/modernizr -c ./node_modules/modernizr/lib/config-all.json
#mv ./modernizr.js ./node_modules/modernizr/modernizr.js
#rsync $opts node_modules/modernizr/modernizr.js "$js_target"

#JQuery validation
#echo "==========================="
#echo "Copy jquery validation"
#echo "==========================="
#rsync $opts node_modules/jquery-validation/dist/jquery.validate.min.js "$js_target"




