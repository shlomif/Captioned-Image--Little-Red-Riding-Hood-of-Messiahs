WIDTH = 600

BASE = little-red-riding-hood-of-messiahs
SVG = $(BASE).svg
DESTBASE = $(BASE)-$(WIDTH)
DESTBASE_default = $(SVG)
PNG = $(DESTBASE).png
JPEG = $(DESTBASE).jpg
WEBP = $(DESTBASE).webp

# PHOTO_DEST = d5gxovp-14e90c16-410d-4433-b1ba-c7af00bb53cb.png
PHOTO_DEST =

all: $(PNG) $(JPEG) $(WEBP)

$(PNG): $(SVG) $(PHOTO_DEST)
	inkscape --export-filename=$@ --export-width=$(WIDTH) $<
	optipng $@

$(DESTBASE_default).webp: $(WEBP)
	cp -f $< $@

$(WEBP): $(PNG)
	gm convert $< $@

$(JPEG): $(PNG)
	gm convert $< $@

$(PHOTO_INTERIM1): $(PHOTO_BASE).jpg
	gm convert -crop 2560x1177 $< $@

clean:
	rm -f little-red-*.png little-red-*.jpg little-red-*.webp

upload: all
	sky -x up $(WEBP)
