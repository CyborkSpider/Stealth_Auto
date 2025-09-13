#!/bin/bash

# 🛡️ إعداد تلقائي لحماية الهوية أثناء تنفيذ الهجمات من Kali Linux
# مخصص لاستخدام أدوات اختبار الاختراق دون ترك آثار أو كشف الهوية

interface="eth0"  # ← غيّرها لو بتستخدم Wi-Fi (مثلاً wlan0)

echo "[✔] تشغيل نمط التخفي التلقائي - سيتم تحديث كل 5 دقائق"
sleep 2

while true; do
    echo "[+] تغيير MAC Address..."
    ifconfig $interface down
    macchanger -r $interface
    ifconfig $interface up

    echo "[+] إعادة تشغيل خدمة Tor..."
    systemctl restart tor

    echo "[+] حذف سجلات الأنشطة والباش..."
    history -c
    cat /dev/null > ~/.bash_history
    rm -f /var/log/auth.log /var/log/syslog /var/log/messages 2>/dev/null

    echo "[✔] تم إخفاء الهوية... الانتظار 5 دقائق قبل التكرار"
    sleep 300  # ← 300 ثانية = 5 دقائق
done
