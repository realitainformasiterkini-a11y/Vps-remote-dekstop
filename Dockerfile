# Dockerfile for XFCE + Chrome Remote Desktop + Custom User Data
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install XFCE and Chrome Remote Desktop dependencies
RUN apt-get update && \
    apt-get install -y xfce4 xfce4-goodies sudo wget curl dbus-x11 x11-xserver-utils \
        firefox libreoffice gimp scrot && \
            apt-get clean

            # Install Chrome Remote Desktop
            RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb && \
                apt-get install -y ./chrome-remote-desktop_current_amd64.deb && \
                    rm chrome-remote-desktop_current_amd64.deb

                    # Create user and set password
                    RUN useradd -m -s /bin/bash sukrimardana && \
                        echo "sukrimardana:password" | chpasswd && \
                            usermod -aG sudo sukrimardana

                            # Create necessary directories
                            RUN mkdir -p /home/sukrimardana/.config \
                                /home/sukrimardana/Desktop \
                                    /home/sukrimardana/Documents \
                                        /home/sukrimardana/backups \
                                            /home/sukrimardana/scripts

                                            # Copy backup configs (if exist)
                                            COPY --chown=sukrimardana:sukrimardana backups/ /home/sukrimardana/backups/ 2>/dev/null || true

                                            # Copy scripts
                                            COPY --chown=sukrimardana:sukrimardana scripts/ /home/sukrimardana/scripts/ 2>/dev/null || true

                                            # Copy app.bin if exists
                                            COPY --chown=sukrimardana:sukrimardana app.bin /home/sukrimardana/ 2>/dev/null || true

                                            # Restore configs on build (optional, better done on container start)
                                            RUN if [ -d /home/sukrimardana/backups/xfce4 ]; then \
                                                  mkdir -p /home/sukrimardana/.config/xfce4 && \
                                                        cp -r /home/sukrimardana/backups/xfce4/* /home/sukrimardana/.config/xfce4/ 2>/dev/null || true; \
                                                            fi && \
                                                                if [ -d /home/sukrimardana/backups/shell ]; then \
                                                                      cp /home/sukrimardana/backups/shell/.bashrc /home/sukrimardana/ 2>/dev/null || true; \
                                                                            cp /home/sukrimardana/backups/shell/.bash_aliases /home/sukrimardana/ 2>/dev/null || true; \
                                                                                fi && \
                                                                                    if [ -d /home/sukrimardana/backups/Desktop ]; then \
                                                                                          cp -r /home/sukrimardana/backups/Desktop/* /home/sukrimardana/Desktop/ 2>/dev/null || true; \
                                                                                              fi

                                                                                              # Set permissions
                                                                                              RUN chown -R sukrimardana:sukrimardana /home/sukrimardana && \
                                                                                                  chmod +x /home/sukrimardana/scripts/*.sh 2>/dev/null || true && \
                                                                                                      chmod +x /home/sukrimardana/app.bin 2>/dev/null || true

                                                                                                      # Expose necessary ports
                                                                                                      EXPOSE 3389

                                                                                                      # Switch to user
                                                                                                      USER sukrimardana
                                                                                                      WORKDIR /home/sukrimardana

                                                                                                      # Default command
                                                                                                      CMD ["/bin/bash"]