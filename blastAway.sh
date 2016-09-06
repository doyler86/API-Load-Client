#!/bin/bash

ENDPOINTS_FILE="endpoints.config"

genRandNum () {

	MIN=$1
	MAX=$2
	awk -v min=${MIN} -v max=${MAX} 'BEGIN{srand(); print int(min+rand()*(max-min+1))}'
	#Return NUM //showing what is returned, as bash doesnt support this sort of return
}


doMagic () {

	while IFS='' read -r ENDPOINT || [[ -n "$ENDPOINT" ]]; do
    		QUANTITY=`genRandNum 5 50`
		CONCURRENCY=`genRandNum 1 5`
		DELAY=`genRandNum 20 400`
	        #ab -n ${QUANTITY} -c ${CONCURRENCY} "${ENDPOINT}?delay=${DELAY}"
	        ab -n ${QUANTITY} -c ${CONCURRENCY} "${ENDPOINT}"
	done < "${ENDPOINTS_FILE}"

}

doMagic
