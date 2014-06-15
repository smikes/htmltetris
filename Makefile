JSSOURCES=$(shell find bin lib -name '*.js' -print)
CPPSOURCES=$(shell echo src/*.{cc,h})
DOCDIRS=src lib

default: build test

install:
	(unset tmp temp; npm i)

prepublish: lint doc test no-dos-endings check-coverage jstest-slow

lint: jslint doclint

cpplint:
	./node_modules/.bin/node-cpplint $(CPPSOURCES)

jslint:
	./node_modules/.bin/jslint --terse -- $(JSSOURCES) ; echo

doclint:
	./node_modules/.bin/yuidoc $(DOCDIRS) --lint

test: jstest

test-slow: jstest-slow

jstest:
	./node_modules/.bin/mocha

jstest-slow:
	./node_modules/.bin/mocha -t 10000 -s 5000 test/slow

build:
	(unset tmp temp; npm run-script build)

rebuild:
	(unset tmp temp; npm run-script rebuild)

cpptest:
	./build/Release/test


no-dos-endings:
	file $(JSSOURCES) | grep -v CRLF > /dev/null

# coverage only for javascript at this point
cover: $(JSSOURCES)
	./node_modules/.bin/istanbul cover --print=both ./node_modules/mocha/bin/_mocha --

check-coverage: cover
	./node_modules/.bin/istanbul check-coverage --statements 90 --branches 90 --functions 90 --lines 90

doc:
	./node_modules/.bin/yuidoc $(DOCDIRS)

tags:
	find src deps | egrep "\.(c|h|cc|cpp)$\" | xargs etags
	find src deps | egrep "\.(c|h|cc|cpp)$\" | xargs ebrowse

clean:
	-find . -name "*~" | xargs rm

.PHONY: install jslint cpplint cpptest jstest doc no-dos-endings check-coverage build tags clean
