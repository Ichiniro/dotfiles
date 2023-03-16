# Shell variables

# Special
bg='#fbf1f2'
fg='#8b8198'
cursor='#8b8198'

# Colors
col0='#fbf1f2'
col1='#D57E85'
col2='#A3B367'
col3='#DCB16C'
col4='#7297B9'
col5='#BB99B4'
col6='#69A9A7'
col7='#8b8198'
col8='#bfb9c6'

# FZF colors
export FZF_DEFAULT_OPTS="
    $FZF_DEFAULT_OPTS
    --color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
    --color info:7,prompt:2,spinner:1,pointer:232,marker:1
"

# Fix LS_COLORS being unreadable.
export LS_COLORS="${LS_COLORS}:su=30;41:ow=30;42:st=30;44:"
