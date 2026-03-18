# Regras para o agenix: quais chaves podem descriptografar cada secret.
# Criar/editar secrets: agenix -e <nome>.age (a partir deste diretório).
let
  # Mesma chave age usada no SOPS (pública)
  huginnKey = "age1xq3z687rz0fz4n7ulnl2vcj5hw7dcaugs7fq6zz0d7waa3rntgdq94hdhl";
  defaultPubKeys = [ huginnKey ];
in
{
  "gemini_api_key.age".publicKeys = defaultPubKeys;
  "ssh_private_personal.age".publicKeys = defaultPubKeys;
  "ssh_public_personal.age".publicKeys = defaultPubKeys;
  "ssh_private_mk.age".publicKeys = defaultPubKeys;
  "ssh_public_mk.age".publicKeys = defaultPubKeys;
  "ssh_private_fenrir.age".publicKeys = defaultPubKeys;
  "ssh_public_fenrir.age".publicKeys = defaultPubKeys;
  "ssh_private_mk_server.age".publicKeys = defaultPubKeys;
  "ssh_public_mk_server.age".publicKeys = defaultPubKeys;
  "otp_aegis.age".publicKeys = defaultPubKeys;
}
