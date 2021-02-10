
find /scripts/ -name "*.sh" -exec chmod 755 {} \;

for ff in /scripts/build.d/*.sh
do
	if [ -e "${ff}" ]; then
		echo "[INFO] build.d - processing $ff"
		. ${ff}
		# mark it done
		mv ${ff} ${ff}-executed
	fi
done
