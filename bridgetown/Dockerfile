FROM public.ecr.aws/lambda/ruby:3.2


RUN yum -y groupinstall "Development Tools"
# Copy Gemfile and Gemfile.lock
COPY energy_tables/Gemfile ${LAMBDA_TASK_ROOT}/


# Install Bundler and the specified gems
RUN gem install bundler:2.4.14 && \
    bundle config set --local path 'vendor/bundle' && \
    bundle config set cache_all true 

RUN cd ${LAMBDA_TASK_ROOT} && bundle package && bundle install --local

# Copy function code
COPY handler.rb ${LAMBDA_TASK_ROOT}/

COPY energy_tables/ ${LAMBDA_TASK_ROOT}/

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "handler.handler" ]
