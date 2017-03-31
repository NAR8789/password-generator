CACHE_DIR=cache
EN_FULL=${CACHE_DIR}/en_full.txt
WORD_LIST=word_list.txt
DICTIONARY_SIZE?=8192

all: ${WORD_LIST}
	head -n ${DICTIONARY_SIZE} word_list.txt | ./generate.sh

${WORD_LIST}: ${EN_FULL}
	cat ${EN_FULL} \
	  | perl -pe 's# [0-9]+$$##' \
	  | (iconv -f UTF-8 -t ASCII -c; true) \
	  | perl -ne '$$H{$$_}++ or print' \
	  > ${WORD_LIST}

${EN_FULL}: ${CACHE_DIR}
	curl https://raw.githubusercontent.com/hermitdave/FrequencyWords/master/content/2016/en/en_full.txt > ${EN_FULL}

${CACHE_DIR}:
	mkdir -p ${CACHE_DIR}

clean:
	rm -rf ${CACHE_DIR} ${WORD_LIST}
