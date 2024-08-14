ARG BASE_IMAGE=10.56.184.75:8000/system_containers/alpine:3.20

# Final Docker image
FROM ${BASE_IMAGE} AS final-stage
LABEL MAINTAINER "Thomas Labarussias <issif+falcosidekick@gadz.org>"
RUN apk add --update --no-cache ca-certificates
# Create user falcosidekick
RUN addgroup -S falcosidekickui && adduser -u 1234 -S falcosidekickui -G falcosidekickui
# must be numeric to work with Pod Security Policies:
# https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups
USER 1234
WORKDIR /app
COPY frontend/dist frontend/dist
COPY LICENSE .
COPY falcosidekick-ui .

EXPOSE 2802
ENTRYPOINT ["./falcosidekick-ui"]
