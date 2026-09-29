const API_URL = "/api/incidents";

async function loadIncidents() {

    try {

        const response = await fetch(API_URL);

        const incidents = await response.json();

        updateDashboard(incidents);

    } catch (error) {

        console.error(
            "Unable to connect to LinuxOps API:",
            error
        );
    }
}


function updateDashboard(incidents) {

    document.getElementById("total")
        .textContent = incidents.length;

    const openIncidents =
        incidents.filter(
            incident => incident.status === "OPEN"
        );

    const highIncidents =
        incidents.filter(
            incident => incident.severity === "HIGH"
        );

    const resolvedIncidents =
        incidents.filter(
            incident => incident.status === "RESOLVED"
        );

    document.getElementById("open")
        .textContent = openIncidents.length;

    document.getElementById("high")
        .textContent = highIncidents.length;

    document.getElementById("resolved")
        .textContent = resolvedIncidents.length;


    const table =
        document.getElementById("incidentTable");

    table.innerHTML = "";

    incidents.forEach(incident => {

        const row = document.createElement("tr");

        row.innerHTML = `
            <td>${incident.id}</td>
            <td>${incident.type}</td>
            <td>${incident.severity}</td>
            <td>${incident.status}</td>
            <td>${incident.source}</td>
            <td>${incident.createdAt}</td>
        `;

        table.appendChild(row);
    });
}


loadIncidents();

setInterval(loadIncidents, 10000);