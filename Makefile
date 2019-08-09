
development-image:
	docker build --build-arg CXX_OPTIMIZATION_LEVEL=0 --tag buster/rdt:1.0:development .

production-image:
	docker build --build-arg CXX_OPTIMIZATION_LEVEL=0 --tag buster/rdt:1.0:production .
