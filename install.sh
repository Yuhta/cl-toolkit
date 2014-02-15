#!/bin/sh

sbcl_home=`echo '(princ (directory-namestring *core-pathname*))' | sbcl --script`
[ -z "$sbcl_home" ] && echo "Unable to detect SBCL home" && exit 1
install_dir="$sbcl_home"contrib

script=`readlink -f "$0"`
source_dir=`dirname "$script"`
for src in "$source_dir/"*.lisp; do
    echo "(compile-file \"$src\")" | sbcl --script
done

set -x
cp "$source_dir/"*.asd "$install_dir"
mv "$source_dir/"*.fasl "$install_dir"
