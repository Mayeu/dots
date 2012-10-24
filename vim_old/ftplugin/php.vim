" Syntax check
setlocal makeprg=php\ -l\ %
setlocal errorformat=%m\ in\ %f\ on\ line\ %l

let php_sql_query=1 "Highlight SQL Query
let php_htmlInStrings=1 "Highlight HTML in string
let php_folding = 1 "Folding

