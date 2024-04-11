#!/bin/bash

#figure out where we are

[ $(hostname -s) == "dev2013" ] && site=sv4 && env=dev

[ $(hostname -s) == "stg555" ] && site=sv4 && env=stg
[ $(hostname -s) == "stgf1088" ] && site=fr8 && env=stg

[ $(hostname -s) == "prod10506" ] && site=sv1 && env=prod
[ $(hostname -s) == "prod41773" ] && site=ch3 && env=prod
[ $(hostname -s) == "prod3029" ] && site=sha && env=prod
[ $(hostname -s) == "prod9088" ] && site=fr8 && env=prod

[ $(hostname -s) == "prod8073" ] && site=cdg && env=dr
[ $(hostname -s) == "prod7012" ] && site=de2 && env=dr

commonname=$site-$env

# and what our WCP is

supervisor=$(tanzu tmc management-cluster list -o json | jq -r '.managementClusters[] | "\(.meta.labels.cn),\(.fullName.name)"' | csvgrep -H -c 1 -m ${commonname} | csvcut -c 2 | tail -n +2)

# from the WCP cluster list, change context to that cluster
# run the kit
# and rename the output file

echo "<html>" > html/index.html
echo "<head><title>${supervisor}</title></head>" >> html/index.html
echo "<body><table>" >> html/index.html

for cluster in $(tanzu tmc cluster list -m $supervisor -o json | jq -r '.clusters[] | "\(.fullName.name)"')
do
  k ctx $cluster
  go run .
  mv cluster.html html/$cluster.html
  echo "<tr><td><a href=$cluster.html>${cluster}</a></td</tr>" >> html/index.html
done

ls -1 html/*.html
echo "</table></body></html>" >> html/index.html
