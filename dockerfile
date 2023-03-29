FROM jekyll/jekyll:latest

WORKDIR /srv/jekyll

COPY . .

RUN bundle install

EXPOSE 4000

CMD ["jekyll", "serve", "--watch", "--force_polling", "--host", "0.0.0.0"]