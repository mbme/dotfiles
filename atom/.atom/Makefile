LIST := packages.list

install-all-packages:
	cat $(LIST) | xargs apm install

save-packages-list: 
	rm $(LIST)
	apm list --installed --bare > $(LIST)
	cat $(LIST)
