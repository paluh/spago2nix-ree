psa := psa \
		--is-lib=.spago \
		--stash \
		--censor-lib \
		--strict \
		'.spago/*/*/src/**/*.purs'

build:
	$(psa) 'src/**/*.purs' 'test/**/*.purs'
	parcel build --target node --no-source-maps  src/index.js .
	mkdir -p dist/bin
	echo "#!/usr/bin/env node" > dist/bin/spago2nix
	cat dist/index.js >> dist/bin/spago2nix
	chmod +x dist/bin/spago2nix
	rm dist/index.js

check:
	node -e "require('./output/Test.Main').main()"

installcheck:
	$$out/bin/spago2nix --help