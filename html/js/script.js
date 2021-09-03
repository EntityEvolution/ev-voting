const doc = document;

this.window.addEventListener('load', e => {
    window.addEventListener('message', e => {
        switch (e.data.action) {
            case 'updateInfo':

            break;
        }
    })
})

this.window.addEventListener('DOMContentLoaded', () => {
    fetch('../config.json')
    .then((response) => response.json())
    .then((data) => appendData(data))
    .catch((error) => {console.log('Config Error: ' + error)})
})

function appendData(data) {
    const container = doc.getElementById('container');
    data.forEach(dataItem => {
        const slide = doc.createElement('div');

        const info = doc.createElement('div');
        const infoWave = doc.createElement('div');
        const infoLogo = doc.createElement('img');
        const infoTitle = doc.createElement('span');
        const infoDesc = doc.createElement('span');

        const hover = doc.createElement('div');
        const hoverLocation = doc.createElement('span');
        const hoverBtn = doc.createElement('btn');

        hoverBtn.addEventListener('click', () => {console.log(dataItem.id)})

        // Add classes
        hoverBtn.classList.add('info-btn');
        hoverLocation.classList.add('location');
        hover.classList.add('hover-container');
        infoWave.classList.add('job-wave');
        infoLogo.classList.add('job-logo');
        infoTitle.classList.add('title');
        infoDesc.classList.add('description');
        info.classList.add('info-container');
        slide.classList.add('job-container');

        // Set content
        hoverBtn.textContent = 'Vote Now';
        hoverLocation.textContent = dataItem.place;
        infoTitle.textContent = dataItem.name;
        infoDesc.textContent = dataItem.about;
        infoLogo.src = dataItem.image;
        
        info.append(infoWave, infoLogo, infoTitle, infoDesc);
        hover.append(hoverLocation, hoverBtn);
        slide.append(info, hover);
        container.appendChild(slide);
    });
}