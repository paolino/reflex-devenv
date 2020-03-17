.PHONY: test container


devel:
	 docker exec -it $(shell pwd | xargs basename)-devel bash || docker run --name $(shell pwd | xargs basename)-devel --rm -u 1000:1000 -e LC_ALL=C.UTF-8 -v /var/run/docker.sock:/var/run/docker.sock -v nix:/nix -it -v home:/home/developer  -v `pwd`:/data --network=host  $(h)
esa::
	 docker exec -it $(shell pwd | xargs basename)-devel bash || docker run --name $(shell pwd | xargs basename)-devel --rm -u 1000:1000 -e LC_ALL=C.UTF-8 -v nix:/nix -it -v esa-home:/home/developer  -v `pwd`:/data -p 1222:22  $(h)
