# Dockerfile for XFCE + Chrome Remote Desktop + Custom User Data
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install XFCE and Chrome Remote Desktop dependencies
RUN apt-get update && \
    apt-get install -y xfce4 xfce4-goodies sudo wget curl dbus-x11 x11-xserver-utils && \
    apt-get clean

# Install Chrome Remote Desktop
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb && \
    apt-get install -y ./chrome-remote-desktop_current_amd64.deb && \
    rm chrome-remote-desktop_current_amd64.deb

# Create user and set password
RUN useradd -m -s /bin/bash sukrimardana && echo "sukrimardana:password" | chpasswd && adduser sukrimardana sudo

# Copy custom Desktop files and config (replace with your actual files/folders)
# Example: COPY Desktop /home/sukrimardana/Desktop
# Example: COPY .config /home/sukrimardana/.config

# Set permissions
RUN chown -R sukrimardana:sukrimardana /home/sukrimardana

# Expose necessary ports (if needed)
EXPOSE 3389

CMD ["/bin/bash"]
