
    $Id$

                    Configuration mini-faq

��������� Andrey Slusar 2:467/126, anray@users.sourceforge.net

����� ������ ������ ����� ��������� ����� �������� ������� ��������� ������:
===
To: FAQServer 2:467/126
Subject: FIDOGATE
===
���� �� ������ ������ ��������� ��� ���������� � ������ �������� ����������
������ �� ��������� ������.

����� ������ ����������� ��� ���������� � �������� ���� ��� ����� ������������
�� fidogate �� ���������� ����.

=============================================================================
  
  Q1:� ���� inn �� �����������. �����, ��� ��� history-�����, ���� ����� ����
     �� ����� ���� ����������.
   
  A1:���������� ������� ���������� history inn'a:

    �� root ������:
    ===
    su news
    /usr/local/news/bin/makehistory -b -f history -O -l 30000 -I
    /usr/local/news/bin/makedbz -f history -i -o -s 30000
    exit
    /etc/init.d/innd start
    ===
    ���.
  
-----------------------------------------------------------------------------

  Q2:� ���� ���������� �������� � ���������������, � UPS ���. � ����������
     ����� ������ inn ��� �� ����� �������������� �������� ����� - ��� �����
     � bad.
    
  A2:��� ��������� ���������� ������ ����������� ����� ������ storage ������
     tradspool ��������� timehash. ��� ����� ���������� ������ ��������� �
     storage.conf:
  
  === storage.conf ===
  method timehash {
  newsgroups: *
  class: 0
                  }
  ===		
    
     ��� ��������� ����� - ����� ��������� active-���� � overview �����
     ��������:
  
  === inn-recover.sh ===
  #!/bin/sh
  /usr/local/etc/rc.d/innd.sh stop
  su news -c "/usr/local/news/bin/makehistory -b -f history -O -l 30000 -I"
  /usr/local/etc/rc.d/innd.sh start
  for act in `cat /usr/local/news/db/active | awk '{print $1}'`
  do
   su news -c "/usr/local/news/bin/ctlinnd renumber $act"
  done
  ===
    ���� � ��������������� ������ ����������.
  ���� ���-�� ������� ������������ storage-������� tradspool, �� ����������
  ���������� inn �� ������ >= 2.4.0 � ��������� �������� icdsynccount � inn.conf
  �� 1.
  �� ������ "������ ���?" ����� �������� ������������� ��������� ����� NEWS �
  ��������� � inn >= 2.4.0

-----------------------------------------------------------------------------
  
  Q3:��������� inn � �������� �����������. ������ send-fidogate �� ������� �
    pkt ��������� �������, � � log-news ������� ��������� ������:
    
    === log-news ===
    Aug 21 00:04:51 rfc2ftn WARNING: can't open /usr/local/news/spool/articles/ \
    @050000000017000017AB0000000000000000@ (errno=2: No such file or directory)
    ===

  A3:���� � ���, ��� � ��������� ������� INN ������������ storage API � ���
    ���������� ������ fidogate ����� ��������� send-fidogate:

    ���� � send-fidogate ������: 
    
     time $RFC2FTN -f $BATCHFILE -m 500

    � ������ �� �� �����(��� � ���� �������):

     time $PATHBIN/batcher -N $QUEUEJOBS -b500000 -p"$RFC2FTN -b -n" \
     $SITE $BATCHFILE

    ����� ������������� man batcher.

-----------------------------------------------------------------------------

  Q4:��� ����� �������� ���������, �� ��� ������� runinc ������-�� ������ ��
     ������ - ������� �� ��������. � ����� ��� �����. ��� ������?
    
  A4:���������, ��� ������ ��������� ���������� � ��� runinc-� ������� ����
     ������ � ������.

-----------------------------------------------------------------------------
    
  Q5:�������� leafnode 1.x � leafnode-util �� Elohin Igor, ������ ������ 
     leafnode-group. groupinfo ��������, �� leafnode �� ����� ���������
     �����.
    
  A5:leafnode-group �������� ������ � leafnode 2.x �� "����". � ����������
     �������� leafnode �� �������� �� �����.

-----------------------------------------------------------------------------
    
  Q6:�������� leafnode, �������� ��� ��� ������� � ������ FAQ � inetd.conf
     � services, ������ kill -HUP `cat /var/run/inetd.pid`, ��
     $telnet localhost 119 �� ��������.
  
  A6:���������� ������� ��������� INSTALL � ������ leafnode � ���������
     ��������� ������ � hosts.allow �, ���� � ��� Linux �� hosts.deny.

-----------------------------------------------------------------------------

  Q7:����� inn. ������ ��� ������� configure �� ����� ����� rnews � �� ����� 
     ��-�� ����� ������ ����������� � ��������� ���������?
  
  �7:���� � ���, ��� rnews ������ ����� ����� news:news � ����, �����������
     ������ configure, �� ����� �� rnews ����. ��� ����, ���� configure
     ���������� ���������, ���������� ���� �������� �����, �����������
     �������� � ������ news ���� �������� �� root.

-----------------------------------------------------------------------------

  Q8:������ ������� ��������, �� � ����������� ��������� �� ����������? �
     ����� ���������:
     ===
     Oct 18 22:21:16 ftntoss packet /var/spool/bt/pin/9192da0c.pkt (1622b) from
     2:450/256.0 to 2:450/256.1
     Oct 18 22:21:16 ftntoss WARNING: node 2:450/256.0 have null password
     ===

  A8:���� � ��� ����� ����������� ������, �� �� ������� ��������� � passwd ��
     ��� ������.
     �������, �� ������ ��? � ����� ����� � passwd ������ ����:
     === passwd ===
     packet  2:5030/1469             XXXXXXXX
     packet  2:5030/1229.0           XXXXXXXX
     packet  2:5030/1229.5           XXXXXXXX
     packet  2:5030/1229.6           XXXXXXXX
     packet  2:5030/1229.7           XXXXXXXX
     packet  2:5030/1229.8           XXXXXXXX
     ===
-----------------------------------------------------------------------------

  Q9:������ fidogate ����� 8-� ��� � ��������� ��������? ������� ���������
     ��������� - � ����� ����� ������� plaint text 8bit.
     
  A9:��� ����, ����� ������� fidogate-� ����������� 8-������ ������� �
     ������������ ������, ����� � ���� ������ �������� ���� -8 � areas.

-----------------------------------------------------------------------------

  Q10:������ ��� �������� fidogate � ���� ��������� �������� ����� ���������
      ����� �������������� RFC-�������. ��� ����?

  A10:���������� ��������� ������������ �� ���� ������ RFCLevel � ��������
      ������� � ����� -R ������� areas. � ����������� ������� ����������
      ��������� RFCLevel 0.

----------------------------------------------------------------------------

  Q11:� ��� ����� ������������ ������� ������� � ���, ��� ������ �� ��������?
  
  A11:�������� �� ����� ��������� ������ ����:
  ===
  #!/bin/sh
  #
  # (c) Evgeniy Kozhuhovskiy 2:450/256
  #
  if [ -f /var/log/fidogate/newfiles ] ; then 
   (
    echo "From: FileFix Daemon <filefix@f256.n450.z2.fidonet.org>"
    echo "Newsgroups: fido.pvt.xxx.station.robots"
    echo "Subject: New files arrived"
    echo 
    echo "New files on 2:450/256:"
    echo 
    cat /var/log/fidogate/newfiles
    echo "eof"
   )|inews -h -O -S
   # ��� - �����������
   cat /var/log/fidogate/newfiles >>/var/log/fidogate/newfiles.full
   rm -f /var/log/fidogate/newfiles
  fi
  ===

----------------------------------------------------------------------------

  Q12:����� ����� �����-�� ������������ �� ���� ������ fidogate-ds ���
      �������� � ������� �����?

  A12:��� ������������� �����, ������� ����� ������������ 1 �������, fidogate
      ����� �������� � ������:
      ===
      ./configure --enable-dbc-history
      ===
      ��� �� ��� freebsd ����� WITH_DBC=yes. ����� fidogate ����� �����
      ���� ������������ MSGID/Message-ID � ��� FIDO_MSGID, � ������� ��
      ��������� ���������� fidogate, �� ����� ������� ����� � �����
      ����������� ������� �� ���� Message-ID.

      ��� �������� �����:
      ===
      ./configure --disable-fs-msgid
      ===
      ��� �� ��� freebsd ����� WITHOUT_FMSGID=yes. ����� fidogate �����
      ������ � MSGID ������ �������� Message-ID. ��� ���������� ���
      ������������� � ifmail ������� � fidogate.conf ��������� �����
      GateRfcKludge � RFCLevel 2. ��� - ����������� ���������.
      ������������� �� ���������� �������� fidogate ��� �������� �����
      ��� ����� --disable-fs-msgid, ����� ����� ��������� ��������
      �������� REPLY � � ��������-������� ���������� ����� ������������
      ���������. ���� ������� ��� ����� �������� ��������� dbc-history,
      �� �������� REPLY ����� ���������.

================================================================================
