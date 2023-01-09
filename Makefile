VERSION ?= 0.0.0dev

SRC = $(sort $(wildcard scad/*.scad))
STL = $(SRC:scad/%.scad=stl/%.stl)
DAT = $(STL:stl/%.stl=parts/%.dat)
PNG = $(STL:stl/%.stl=png/%.png)

all: parts.lst $(PNG)

images: $(PNG)

stl: $(STL)

parts.lst: $(DAT)
	@ldraw-mklist -n -f -i parts
	@sqlite3 catalog.db "UPDATE parts SET to_print = 1 WHERE file = 'tool';"
	@sqlite3 catalog.db \
		"UPDATE categories AS c \
		    SET quantity=p.count \
		    FROM (SELECT COUNT(*) AS count, category \
		        FROM parts_categories AS pc \
		        LEFT JOIN parts AS pa ON pa.file = pc.part \
		        WHERE pa.to_print = 1 GROUP BY category) AS p \
		    WHERE c.category = p.category;"

stl/%.stl: scad/%.scad scad/bitbeam-lib/bitbeam-lib.scad
	@echo "$< -> $@"
	@[ -d stl ] || mkdir stl
	@openscad -o $@ $<

catalog.db: catalog.sql
	@echo "$< -> $@"
	@sqlite3 catalog.db < catalog.sql
	@sqlite3 catalog.db "INSERT INTO release VALUES \
		    ('$(VERSION)', CAST(strftime('%s', CURRENT_TIMESTAMP) as integer));"

parts/%.dat: stl/%.stl catalog.db
	@echo "$< -> $@"
	@echo 'scale([2.5, 2.5, 2.5]) rotate([90, 0, 0]) import("$<");' > .tmp.scad
	@openscad -o .tmp.stl .tmp.scad && rm .tmp.scad
	@(	NAME=`sed -n "s/.*NAME:\s*\(.*\)\s*/\1/p" scad/$*.scad` && \
		COLOR=`sed -n "s/.*COLOR:\s*\(.*\)\s*/\1/p" scad/$*.scad` && \
		CATEGORY=`sed -n "s/.*CATEGORY:\s*\(.*\)\s*/\1/p" scad/$*.scad` && \
		KEYWORDS=`sed -n "s/.*KEYWORDS:\s*\(.*\)\s*/\1/p" scad/$*.scad` && \
		[ -n "$$NAME" ] || NAME=$* && \
		[ -n "$$COLOR" ] || COLOR=16 && \
		(echo $* | grep -E '^bb-|^pin-|^shaft-' > /dev/null) && TO_PRINT=1 || TO_PRINT=0 && \
		stl2dat .tmp.stl -ldraw -c1 $$COLOR -c3 $$COLOR -c4 $$COLOR > /dev/null && rm -r .tmp.stl && \
		sed "s/{name}/$$NAME/; s/{file}/parts\/$*.dat/; s/{category}/$$CATEGORY/" header.dat > $@ && \
		sqlite3 catalog.db "INSERT OR REPLACE INTO parts VALUES ('$$NAME', '$*', '$$TO_PRINT');" && \
		[ -n "$$CATEGORY" ] || CATEGORY=Beam && \
		for cat in `echo $$CATEGORY $$KEYWORDS`; do \
			sqlite3 catalog.db "INSERT OR IGNORE INTO categories VALUES ('$$cat', 0);"; \
			sqlite3 catalog.db "INSERT OR IGNORE INTO parts_categories VALUES ('$$cat', '$*');"; \
		done \
	)
	@tail -n +4 .tmp.dat >> $@
	@rm .tmp.dat

png/%.png: scad/%.scad scad/bitbeam-lib/bitbeam-lib.scad
	@echo "$< -> $@"
	@[ -d png ] || mkdir png
	@openscad -o $@ --imgsize=512,512 --projection=p --viewall --colorscheme=Monotone $<
	@# ffffef is Monotone background
	@#convert $@ -transparent '#ffffe5' -scale 50% -colorspace gray -fill '#80a0ff' -tint 70 $@
	@convert $@ -transparent '#ffffe5' -scale 50% $@

release: m-bitbeam-stl-$(VERSION).zip \
	m-bitbeam-parts-$(VERSION).zip \
	m-bitbeam-catalog-$(VERSION).zip

m-bitbeam-stl-$(VERSION).zip: $(STL) LICENSE.md AUTHORS
	zip $@ stl/bb-*.stl stl/washer-*.stl LICENSE.md AUTHORS

m-bitbeam-parts-$(VERSION).zip: parts.lst LICENSE.md AUTHORS
	zip $@ parts/*.dat parts.lst LICENSE.md AUTHORS

m-bitbeam-catalog-$(VERSION).zip: parts.lst $(PNG) LICENSE.md AUTHORS
	zip $@ png/*.png catalog.db LICENSE.md AUTHORS

docker-build:
	docker build \
		-t ondratu/m-bitbeam .
	docker run \
		--rm \
		-w "$(CURDIR)" \
		-v "$(CURDIR):$(CURDIR)" \
		ondratu/m-bitbeam

docker-console:
	docker build \
		-t ondratu/m-bitbeam .
	docker run \
		-ti \
		--rm \
		-w "$(CURDIR)" \
		-v "$(CURDIR):$(CURDIR)" \
		--entrypoint '' \
		ondratu/m-bitbeam \
		bash

clean-dat:
	rm -f $(DAT)
	rm -f parts.lst catalog.db

clean: clean-dat
	rm -rf stl png
	rm -f *.zip
	docker rmi -f ondratu/m-bitbeam || true
