FROM arthurpicht/debian-9:0.1

ENV DOCKER_NAME="jdk-12"
ENV JAVA_HOME /man/java
ENV PATH $JAVA_HOME/bin:$PATH

# TEMP: cache file locally, dev-time only
# COPY openjdk.tar.gz .

RUN set -eux; \
	export OPENJDK_URL="https://download.java.net/java/GA/jdk12.0.1/69cfe15208a647278a19ef0990eea691/12/GPL/openjdk-12.0.1_linux-x64_bin.tar.gz"; \
	export OPENJDK_FILE=openjdk.tar.gz; \
	export OPENJDK_SHA256_URL="https://download.java.net/java/GA/jdk12.0.1/69cfe15208a647278a19ef0990eea691/12/GPL/openjdk-12.0.1_linux-x64_bin.tar.gz.sha256"; \
	export OPENJDK_SHA256_FILE=openjdk.tar.gz.sha256; \
	wget -O "$OPENJDK_FILE" "$OPENJDK_URL"; \	
	wget -O "$OPENJDK_SHA256_FILE" "$OPENJDK_SHA256_URL"; \
	HASH=$(cat $OPENJDK_SHA256_FILE); \
	HASH="$HASH $OPENJDK_FILE"; \
	echo $HASH | sha256sum -c; \
	mkdir -p "$JAVA_HOME"; \
	tar --extract \
		--file "$OPENJDK_FILE" \
		--directory "$JAVA_HOME" \
		--strip-components 1 \
		--no-same-owner \
	; \
	rm "$OPENJDK_FILE"; \
	echo "$OPENJDK_URL" >> /.components; \
	javac --version; \
	java --version; 
