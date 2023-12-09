upstream logs {
	server 0.0.0.0:3100;	
}

server {
	server_name logs.pogaparking.ru;

	if ($scheme != "https") {
		return 301 https://$host$request_uri;
	}

	client_max_body_size 0;
	chunked_transfer_encoding on;

	proxy_buffering off;
	proxy_request_buffering off;

	location / {
		proxy_pass http://logs/;
		proxy_set_header Host $http_host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header X-Forwarded-Proto $scheme;

		proxy_http_version 1.1;
		proxy_set_header Connection "";
	}
	
	listen [::]:443; # managed by Certbot
    	ssl on;
	listen 443 ssl; # managed by Certbot	
    	ssl_certificate /etc/letsencrypt/live/logs.pogaparking.ru/fullchain.pem; # managed by Certbot
    	ssl_certificate_key /etc/letsencrypt/live/logs.pogaparking.ru/privkey.pem; # managed by Certbot
    	include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    	ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    	if ($host = logs.pogaparking.ru) {
        	return 301 https://$host$request_uri;
    	} # managed by Certbot


	listen 80 ;
	listen [::]:80 ;
    	server_name logs.pogaparking.ru;
    	return 404; # managed by Certbot
}
