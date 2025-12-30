<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RestTemplate - Gestion des employés</title>
    <style>
        :root{
            --bg1:#0b1020;
            --bg2:#0f1a33;
            --card:#0f1730cc;
            --text:#e9eefc;
            --muted:#a9b6db;
            --accent:#5b8cff;
            --accent2:#22c55e;
            --border:rgba(255,255,255,.12);
            --shadow: 0 18px 50px rgba(0,0,0,.45);
            --radius: 18px;
        }

        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial, "Apple Color Emoji","Segoe UI Emoji";
            color:var(--text);
            background:
                    radial-gradient(1200px 600px at 20% 10%, rgba(91,140,255,.35), transparent 60%),
                    radial-gradient(1000px 700px at 80% 20%, rgba(34,197,94,.20), transparent 55%),
                    linear-gradient(160deg, var(--bg1), var(--bg2));
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
            padding:28px;
        }

        .wrap{
            width: min(980px, 100%);
            display:grid;
            grid-template-columns: 1.2fr .8fr;
            gap:20px;
        }

        .card{
            background:var(--card);
            border:1px solid var(--border);
            border-radius:var(--radius);
            box-shadow:var(--shadow);
            padding:28px;
            backdrop-filter: blur(10px);
        }

        .brand{
            display:flex;
            align-items:center;
            gap:12px;
            margin-bottom:18px;
        }
        .logo{
            width:44px;height:44px;
            border-radius:14px;
            background: linear-gradient(135deg, var(--accent), #9b5cff);
            box-shadow: 0 10px 22px rgba(91,140,255,.25);
            display:grid;
            place-items:center;
            font-weight:800;
        }
        h1{
            margin:0;
            font-size: clamp(20px, 3vw, 28px);
            letter-spacing:.2px;
        }
        .subtitle{
            margin:8px 0 0;
            color:var(--muted);
            line-height:1.55;
            max-width:60ch;
        }

        .actions{
            margin-top:22px;
            display:flex;
            gap:12px;
            flex-wrap:wrap;
        }

        .btn{
            display:inline-flex;
            align-items:center;
            gap:10px;
            padding:12px 16px;
            border-radius:14px;
            text-decoration:none;
            color:var(--text);
            border:1px solid var(--border);
            transition: transform .15s ease, box-shadow .15s ease, border-color .15s ease;
            user-select:none;
        }
        .btn:hover{
            transform: translateY(-2px);
            border-color: rgba(255,255,255,.22);
            box-shadow: 0 12px 26px rgba(0,0,0,.35);
        }

        .btn.primary{
            background: linear-gradient(135deg, rgba(91,140,255,.95), rgba(155,92,255,.90));
            border-color: rgba(91,140,255,.35);
        }
        .btn.success{
            background: linear-gradient(135deg, rgba(34,197,94,.95), rgba(16,185,129,.85));
            border-color: rgba(34,197,94,.35);
        }

        .icon{
            width:34px;height:34px;
            border-radius:12px;
            background: rgba(255,255,255,.10);
            display:grid;
            place-items:center;
            font-weight:800;
        }

        .side{
            display:flex;
            flex-direction:column;
            gap:14px;
        }
        .stat{
            display:flex;
            gap:12px;
            align-items:flex-start;
            padding:16px;
            border-radius:16px;
            border:1px solid var(--border);
            background: rgba(255,255,255,.06);
        }
        .stat b{ display:block; margin-bottom:4px; }
        .stat p{ margin:0; color:var(--muted); line-height:1.55; }

        .footer{
            margin-top:18px;
            font-size:13px;
            color: rgba(233,238,252,.72);
        }

        @media (max-width: 820px){
            .wrap{ grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
<div class="wrap">
    <!-- Main card -->
    <div class="card">
        <div class="brand">
            <div class="logo">RT</div>
            <div>
                <h1>Gestion des employés</h1>
                <div class="subtitle">
                    Front-end (JSP) consommant le Back-end via <b>RestTemplate</b>.
                    Utilise les boutons ci-dessous pour ajouter ou consulter les employés.
                </div>
            </div>
        </div>

        <div class="actions">
            <a class="btn primary" href="empform">
                <span class="icon">+</span>
                <span><b>Ajouter</b><br><small style="opacity:.85">Créer un employé</small></span>
            </a>

            <a class="btn success" href="viewemp">
                <span class="icon">≡</span>
                <span><b>Afficher</b><br><small style="opacity:.85">Liste des employés</small></span>
            </a>
        </div>

        <div class="footer">
            • Serveur Back attendu : <code style="background:rgba(255,255,255,.08); padding:2px 8px; border-radius:10px; border:1px solid rgba(255,255,255,.12);">http://localhost:9090</code> <br/> <br/>
            • Front : <code style="background:rgba(255,255,255,.08); padding:2px 8px; border-radius:10px; border:1px solid rgba(255,255,255,.12);">http://localhost:9191</code>
        </div>
    </div>

    <!-- Side info -->
    <div class="side">
        <div class="card">
            <div class="stat">
                <div class="icon">⚙</div>
                <div>
                    <b>Actions disponibles</b>
                    <p>Ajouter / consulter / modifier / supprimer des employés depuis l’interface.</p>
                </div>
            </div>
            <div class="stat" style="margin-top:12px;">
                <div class="icon">↔</div>
                <div>
                    <b>Communication</b>
                    <p>Le front appelle les endpoints REST du back via <b>RestTemplate.</b>
                </div>
            </div>
        </div>

        <div class="card" style="opacity:.95">
            <b>Conseil</b>
            <p style="margin:8px 0 0; color:var(--muted); line-height:1.6;">
                Si la page “View Employees” affiche une erreur, vérifie que le back tourne bien sur le port 9090
                et que <code style="background:rgba(255,255,255,.08); padding:2px 8px; border-radius:10px; border:1px solid rgba(255,255,255,.12);">server.rest.url</code>
                pointe vers <code style="background:rgba(255,255,255,.08); padding:2px 8px; border-radius:10px; border:1px solid rgba(255,255,255,.12);">/rest/emp</code>.
            </p>
        </div>
    </div>
</div>
</body>
</html>
