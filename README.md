# NVM Node Frameworks docker image

To run this simple do:

0- Build the docker image (needed once)
    `docker build . -t  nvm` 

1- Start the container and attach to it: 
    ```
	docker run -p 443:8443 -v `pwd`:/project -ti nvm bash
	```

2- Change to project directory
    `cd  project_folder`

3- Install dependencies
    `npm install`

4- Run the app
    `npm run `
    
