#!/bin/sh

N=0
FNAME='autoconfig'

while read LINE; do
  N=$((N+1))
  PROXY_IP=$(echo "$LINE" | cut -d',' -f3)
  PROXY_PORT=$(echo "$LINE" | cut -d',' -f4)

  echo "//Firefox proxy server settings\r\n\r"                                                                          > /tmp/${FNAME}${N}.js
  echo "user_pref(\"app.update.enabled\", false);\r"                                                                    >> /tmp/${FNAME}${N}.js 
  echo "user_pref(\"browser.rights.3.shown\", true);\r"                                                                     >> /tmp/${FNAME}${N}.js
  echo "user_pref(\"browser.startup.homepage_override.mstone\",\"ignore\");\r"                                              >> /tmp/${FNAME}${N}.js
  echo "user_pref(\"browser.startup.homepage\",\"http://pingtool.org\");\r" >> /tmp/${FNAME}${N}.js
  echo "user_pref(\"datareporting.policy.dataSubmissionEnabled\", false);\r"                                            >> /tmp/${FNAME}${N}.js
  echo "user_pref(\"toolkit.crashreporter.enabled\", false);\r\n\r"                                                     >> /tmp/${FNAME}${N}.js

  echo "user_pref(\"network.proxy.type\", 1);\r"                                                               >> /tmp/${FNAME}${N}.js
  echo "user_pref(\"network.proxy.socks\", \"$PROXY_IP\");\r"                                                               >> /tmp/${FNAME}${N}.js
  echo "user_pref(\"network.proxy.socks_port\", $PROXY_PORT);\r"                                                          >> /tmp/${FNAME}${N}.js
  echo "user_pref(\"network.proxy.share_proxy_settings\", false);\r"                                                         >> /tmp/${FNAME}${N}.js

done <proxy.csv
