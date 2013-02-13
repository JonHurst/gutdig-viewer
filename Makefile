dirs = $(notdir $(wildcard ../dig/*))
viewers = $(foreach dir, $(dirs), $(dir)-index.html)
indexes = $(foreach dir, $(dirs), $(dir).html)
all: $(viewers) $(indexes)

define BOOK_template
$(info Generating rules for $(1))
$(1).html : rtt.xsl ../dig/$(1)/rtt.xml ../dig/$(1)/text/*
	xsltproc --xinclude --stringparam baseURI "../dig/$(1)/" rtt.xsl ../dig/$(1)/rtt.xml > $(1).html
$(1)-index.html : rtt-index.xsl ../dig/$(1)/rtt.xml ../dig/$(1)/text/*
	xsltproc --xinclude --stringparam baseURI "../dig/$(1)/" rtt-index.xsl ../dig/$(1)/rtt.xml > $(1)-index.html
endef

$(foreach dir, $(dirs), $(eval $(call BOOK_template,$(dir))))
