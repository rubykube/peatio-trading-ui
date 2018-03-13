FROM ruby:2.5.0

MAINTAINER lbellet@heliostech.fr

# By default image is built using RAILS_ENV=production.
# You may want to customize it:
#
#   --build-arg RAILS_ENV=development
#
# See https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables-build-arg
#
ARG RAILS_ENV=production
ENV RAILS_ENV=${RAILS_ENV} APP_HOME=/home/app

# Create group "app" and user "app".
RUN useradd --system --create-home --home ${APP_HOME} --shell /sbin/nologin --no-log-init --user-group app

WORKDIR $APP_HOME

# Install dependencies defined in Gemfile.
COPY Gemfile Gemfile.lock $APP_HOME/
RUN mkdir -p /opt/vendor/bundle \
 && chown -R app:app /opt/vendor \
 && su app -s /bin/bash -c "bundle install --path /opt/vendor/bundle"

# Copy application sources.
COPY . $APP_HOME
# TODO: Use COPY --chown=app:app when Docker Hub will support it.
RUN chown -R app:app $APP_HOME

# Switch to application user.
USER app

# Initialize application configuration & assets.
RUN ./bin/init_config \
  && bundle exec rake tmp:create assets:precompile

EXPOSE 3000

# The main command to run when the container starts.
CMD ["bundle", "exec", "puma", "--config", "config/puma.rb"]
