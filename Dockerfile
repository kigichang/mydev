ARG GO_VERSION
FROM mygo:${GO_VERSION}

LABEL maintainer="kigi.chang@gmail.com"

# 其他的 ARG 一定要放在 FROM 之後，否則會被清空。

# user account
ARG USER=user

# user password
ARG PW=user

# user id
ARG UID=500

# group id
ARG GID=500

# 建帳號，並改密碼
RUN useradd -m ${USER} --uid ${UID} -s /bin/zsh
RUN echo "${USER}:${PW}" | chpasswd

# 預設 commit message
COPY gitmessage.txt /home/${USER}/.gitmessage.txt

# 預設專案目錄，之後可 mount host 的專案目錄
RUN mkdir /home/${USER}/projects

# 修改權限
RUN chown -R ${UID} /home/${USER}
RUN chgrp -R ${GID} /home/${USER}

# 切換成預設使用者
USER ${UID}:${GID}

# 建立 ssh private key 目錄，之後可 mount host 的 ~/.ssh
RUN mkdir /home/${USER}/.ssh

# Install Oh my zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Oh my tmux
RUN cd /home/${USER} && git clone https://github.com/gpakosz/.tmux.git && ln -s -f .tmux/.tmux.conf && cp .tmux/.tmux.conf.local .

# 將 clipboard 與 mouse 控制打開
RUN sed 's/tmux_conf_copy_to_os_clipboard=false/tmux_conf_copy_to_os_clipboard=true/' /home/${USER}/.tmux.conf.local > /home/${USER}/.tmux.conf.local.tmp
RUN sed 's/#set -g mouse on/set -g mouse on/' /home/${USER}/.tmux.conf.local.tmp > /home/${USER}/.tmux.conf.local
RUN rm /home/${USER}/.tmux.conf.local.tmp

# 預設 git commit message
RUN git config --global commit.template /home/${USER}/.gitmessage.txt

# 設定工作目錄
WORKDIR /home/${USER}
