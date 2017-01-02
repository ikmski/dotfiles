
#
function peco_cd() {
	local selected_dir=$(find . -type d | peco)
	if [ -n "${selected_dir}" ]; then
		cd ${selected_dir}
	fi
}

#
function peco_src() {
	local selected_dir=$(ghq list -p | peco)
	if [ -n "${selected_dir}" ]; then
		cd ${selected_dir}
	fi
}

