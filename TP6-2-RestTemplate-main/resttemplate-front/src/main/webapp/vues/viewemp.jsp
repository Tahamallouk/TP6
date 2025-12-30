<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:url var="homeUrl" value="/" />
<c:url var="addUrl" value="/empform" />
<c:url var="viewUrl" value="/viewemp" />

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Liste des employés</title>

    <style>
        :root{
            --bg1:#0b1020; --bg2:#0f1a33; --card:rgba(15, 23, 48, .78);
            --text:#e9eefc; --muted:#a9b6db; --accent:#5b8cff; --danger:#ff4d4d;
            --border:rgba(255,255,255,.12); --shadow: 0 18px 50px rgba(0,0,0,.45);
            --radius: 18px;
        }
        *{ box-sizing:border-box; }
        body{
            margin:0; font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial;
            color:var(--text);
            background:
                    radial-gradient(1200px 600px at 20% 10%, rgba(91,140,255,.35), transparent 60%),
                    radial-gradient(1000px 700px at 80% 20%, rgba(34,197,94,.20), transparent 55%),
                    linear-gradient(160deg, var(--bg1), var(--bg2));
            min-height:100vh; padding:28px; display:flex; align-items:flex-start; justify-content:center;
        }
        .container{ width:min(1050px, 100%); }
        .card{
            background:var(--card); border:1px solid var(--border); border-radius:var(--radius);
            box-shadow:var(--shadow); padding:22px; backdrop-filter: blur(10px);
        }
        .top{ display:flex; align-items:flex-start; justify-content:space-between; gap:12px; margin-bottom:14px; }
        h1{ margin:0; font-size: clamp(20px, 3vw, 28px); letter-spacing:.2px; }
        .subtitle{ margin:8px 0 0; color:var(--muted); line-height:1.55; }

        .actions{ display:flex; gap:10px; flex-wrap:wrap; justify-content:flex-end; align-items:center; }

        .btn{
            border:none; cursor:pointer; padding:10px 14px; border-radius:14px;
            color:var(--text); background: rgba(255,255,255,.08); border:1px solid var(--border);
            transition: transform .15s ease, box-shadow .15s ease, border-color .15s ease;
            text-decoration:none; display:inline-flex; align-items:center; gap:10px;
            user-select:none; white-space:nowrap;
        }
        .btn:hover{
            transform: translateY(-2px); border-color: rgba(255,255,255,.22);
            box-shadow: 0 12px 26px rgba(0,0,0,.35);
        }
        .btn.primary{
            background: linear-gradient(135deg, rgba(91,140,255,.95), rgba(155,92,255,.90));
            border-color: rgba(91,140,255,.35); font-weight:700;
        }

        .table-wrap{
            margin-top:16px; border:1px solid var(--border); border-radius:16px;
            overflow:hidden; background: rgba(255,255,255,.05);
        }
        table{ width:100%; border-collapse:collapse; }
        thead th{
            text-align:left; font-size:13px; letter-spacing:.4px; color: rgba(233,238,252,.85);
            padding:12px 14px; background: rgba(255,255,255,.06); border-bottom:1px solid var(--border);
        }
        tbody td{
            padding:12px 14px; border-bottom:1px solid rgba(255,255,255,.08);
            color: rgba(233,238,252,.95); vertical-align:middle;
        }
        tbody tr:hover{ background: rgba(255,255,255,.06); }

        .muted{ color: var(--muted); }
        .badge{
            display:inline-flex; align-items:center; gap:8px; padding:6px 10px; border-radius:999px;
            border:1px solid rgba(255,255,255,.14); background: rgba(255,255,255,.06);
            font-size:12px; color: rgba(233,238,252,.92);
        }
        .badge.salary{ border-color: rgba(34,197,94,.22); background: rgba(34,197,94,.10); }

        .btn-mini{ padding:8px 10px; border-radius:12px; font-size:13px; gap:8px; }
        .btn-mini.danger{ border-color: rgba(255,77,77,.28); background: rgba(255,77,77,.10); }

        .empty{ padding:18px; color: var(--muted); text-align:center; }

        .footer{
            margin-top:14px; display:flex; justify-content:space-between; gap:12px; flex-wrap:wrap;
            color: rgba(233,238,252,.72); font-size:13px;
        }
        code{
            background:rgba(255,255,255,.08); border:1px solid rgba(255,255,255,.12);
            padding:2px 8px; border-radius:10px;
        }
    </style>

    <script>
        function confirmDelete(id){
            return confirm("Supprimer l'employé ID = " + id + " ?");
        }
    </script>
</head>

<body>
<div class="container">
    <div class="card">
        <div class="top">
            <div>
                <h1>Liste des employés</h1>
                <div class="subtitle">Consultation des employés via <b>RestTemplate</b>.</div>
            </div>

            <div class="actions">
                <a class="btn" href="${homeUrl}">← Accueil</a>
                <a class="btn primary" href="${addUrl}">+ Ajouter</a>
            </div>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                <tr>
                    <th style="width:90px;">ID</th>
                    <th>Nom</th>
                    <th style="width:170px;">Salaire</th>
                    <th style="width:190px;">Fonction</th>
                    <th style="width:180px;">Actions</th>
                </tr>
                </thead>

                <tbody>
                <c:if test="${empty list}">
                    <tr><td class="empty" colspan="5">Aucun employé trouvé.</td></tr>
                </c:if>

                <c:forEach var="empVo" items="${list}">
                    <c:url var="editUrl" value="/editemp/${empVo.id}" />
                    <c:url var="deleteUrl" value="/deleteemp/${empVo.id}" />

                    <tr>
                        <td class="muted"><b>#${empVo.id}</b></td>

                        <td><div style="font-weight:700;">${empVo.firstName}</div></td>

                        <td><span class="badge salary">💰 ${empVo.salaire}</span></td>

                        <td><span class="badge">🧩 ${empVo.fonction}</span></td>

                        <td>
                            <a class="btn btn-mini" href="${editUrl}">✏️ Edit</a>
                            <a class="btn btn-mini danger"
                               href="${deleteUrl}"
                               onclick="return confirmDelete(${empVo.id});">
                                🗑 Delete
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="footer">
            <div>Endpoint Back : <code>/rest/emp</code></div>
            <div>Astuce : Edit pour modifier, Delete pour supprimer.</div>
        </div>
    </div>
</div>
</body>
</html>
