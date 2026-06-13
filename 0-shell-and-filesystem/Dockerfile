FROM ubuntu:22.04
# Seed a miniature FHS-like tree at /lab so learners practice safely
RUN mkdir -p /lab/configs /lab/logs /lab/scripts /lab/users /lab/tmp
COPY lab/ /lab/
WORKDIR /lab
CMD ["/bin/bash"]
