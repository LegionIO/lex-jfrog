FROM legionio/legion

COPY . /usr/src/app/lex-jfrog

WORKDIR /usr/src/app/lex-jfrog
RUN bundle install
