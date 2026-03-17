FROM python:3.12-alpine3.20

WORKDIR /app

RUN apk add --no-cache 
gcc 
g++ 
make 
cmake 
musl-dev 
libffi-dev 
linux-headers 
ffmpeg 
aria2 
wget 
unzip

# Install Bento4

RUN wget -q https://github.com/axiomatic-systems/Bento4/archive/v1.6.0-639.zip 
&& unzip v1.6.0-639.zip 
&& cd Bento4-1.6.0-639 
&& mkdir build 
&& cd build 
&& cmake .. 
&& make -j$(nproc) 
&& cp mp4decrypt /usr/local/bin/ 
&& cd /app 
&& rm -rf Bento4-1.6.0-639 v1.6.0-639.zip

COPY . .

RUN pip install --no-cache-dir --upgrade pip 
&& pip install --no-cache-dir -r sainibots.txt 
&& pip install --no-cache-dir yt-dlp

CMD ["python3", "modules/main.py"]
