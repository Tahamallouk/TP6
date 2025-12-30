<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Ajouter un employé</title>

    <style>
        :root{
            --bg1:#0b1020;
            --bg2:#0f1a33;
            --card:rgba(15, 23, 48, .78);
            --text:#e9eefc;
            --muted:#a9b6db;
            --accent:#5b8cff;
            --border:rgba(255,255,255,.12);
            --shadow: 0 18px 50px rgba(0,0,0,.45);
            --radius: 18px;
        }

        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial;
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

        .container{ width:min(860px, 100%); }
        .card{
            background:var(--card);
            border:1px solid var(--border);
            border-radius:var(--radius);
            box-shadow:var(--shadow);
            padding:26px;
            backdrop-filter: blur(10px);
        }

        .top{
            display:flex;
            align-items:flex-start;
            justify-content:space-between;
            gap:12px;
            margin-bottom:18px;
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
            max-width:65ch;
        }

        .back{
            color:var(--text);
            text-decoration:none;
            border:1px solid var(--border);
            padding:10px 12px;
            border-radius:14px;
            background: rgba(255,255,255,.06);
            transition: transform .15s ease, border-color .15s ease, box-shadow .15s ease;
            white-space:nowrap;
        }
        .back:hover{
            transform: translateY(-2px);
            border-color: rgba(255,255,255,.22);
            box-shadow: 0 12px 26px rgba(0,0,0,.35);
        }

        form{ margin-top:16px; }
        .grid{
            display:grid;
            grid-template-columns: 1fr 1fr;
            gap:14px;
        }

        .field{
            display:flex;
            flex-direction:column;
            gap:8px;
        }
        label{
            font-size: 13px;
            color: rgba(233,238,252,.86);
        }

        .input{
            width:100%;
            padding:12px 12px;
            border-radius:14px;
            border:1px solid var(--border);
            background: rgba(255,255,255,.06);
            color: var(--text);
            outline:none;
            transition: border-color .15s ease, box-shadow .15s ease;
        }
        .input:focus{
            border-color: rgba(91,140,255,.55);
            box-shadow: 0 0 0 4px rgba(91,140,255,.18);
        }

        .hint{
            margin:0;
            font-size: 12px;
            color: rgba(169,182,219,.9);
        }

        .actions{
            display:flex;
            gap:10px;
            justify-content:flex-end;
            margin-top:18px;
            flex-wrap:wrap;
        }

        .btn{
            border:none;
            cursor:pointer;
            padding:12px 16px;
            border-radius:14px;
            color:var(--text);
            background: rgba(255,255,255,.08);
            border:1px solid var(--border);
            transition: transform .15s ease, box-shadow .15s ease, border-color .15s ease;
        }
        .btn:hover{
            transform: translateY(-2px);
            border-color: rgba(255,255,255,.22);
            box-shadow: 0 12px 26px rgba(0,0,0,.35);
        }

        .btn.primary{
            background: linear-gradient(135deg, rgba(91,140,255,.95), rgba(155,92,255,.90));
            border-color: rgba(91,140,255,.35);
            font-weight:700;
        }

        @media (max-width: 720px){
            .grid{ grid-template-columns: 1fr; }
        }
    </style>
</head>

<body>
<div class="container">
    <div class="card">

        <div class="top">
            <div>
                <h1>Ajouter un employé</h1>
                <p class="subtitle">
                    Remplis les champs ci-dessous puis clique sur <b>Enregistrer</b>.
                </p>
            </div>
            <a class="back" href="./">← Accueil</a>
        </div>

        <form:form method="post" action="save" modelAttribute="empVo">
            <div class="grid">

                <div class="field">
                    <label for="firstName">Nom (First name)</label>
                    <form:input id="firstName" path="firstName" cssClass="input" placeholder="Ex: Ali" />
                    <p class="hint">Saisis le prénom/nom affiché de l’employé.</p>
                </div>

                <div class="field">
                    <label for="salaire">Salaire</label>
                    <form:input id="salaire" path="salaire" cssClass="input" placeholder="Ex: 8000" />
                    <p class="hint">Valeur numérique (ex: 7500, 12000...).</p>
                </div>

                <div class="field">
                    <label for="fonction">Fonction</label>
                    <form:input id="fonction" path="fonction" cssClass="input" placeholder="Ex: Développeur" />
                    <p class="hint">Exemples : Admin, Manager, Dev...</p>
                </div>

            </div>

            <div class="actions">
                <a class="btn" href="viewemp" style="text-decoration:none; display:inline-flex; align-items:center;">
                    Voir la liste
                </a>
                <button class="btn primary" type="submit">Enregistrer</button>
            </div>
        </form:form>

    </div>
</div>
</body>
</html>
