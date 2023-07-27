let hooks = {}

hooks.key = {
    mounted() {
        let input = document.getElementById('message-input')
        input.addEventListener('keypress', e => {
            if (e.code == 'Enter') {
                if (e.ctrlKey) {
                    this.pushEvent('send_message', { message: { message: e.target.value } })
                    e.target.value = ''
                } else {
                    e.preventDefault()
                    return false;
                }
            }
        }, false)
    }
}

// automatic scroll to bottom of page
hooks.scroll = {
    // when reloading page
    mounted() {
        let target = document.getElementById('scroll-box').lastElementChild;
        target.scrollIntoView(false)
    },
    // when sending text
    updated() {
        let target = document.getElementById('scroll-box').lastElementChild
        target.scrollIntoView(false)
    }
}

export default hooks
