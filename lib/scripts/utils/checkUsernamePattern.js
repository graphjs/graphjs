export default (self) => {
    let failMessage = self.language.usernamePatternError;
    let usernamePattern = /^[a-zA-Z0-9-_]+$/;
    if(usernamePattern.test(self.refs.username.value)) {
        self.refs.username.classList.remove('graphjs-error');
        self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
        return true;
    } else {
        self.refs.username.classList.add('graphjs-error');
        self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
        return false;
    }
}