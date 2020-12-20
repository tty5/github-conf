Name: qb
Version: 1.0
Release: r%{?rel}
Summary: qb
License: ASL 2.0
Packager: qb <qb@qb.com>

# required packages on install
Requires: /bin/sh

%description
qb

%prep

%build

%install
install -d $RPM_BUILD_ROOT/%{_bindir}
install -p -m 755 /usr/bin/qb $RPM_BUILD_ROOT/%{_bindir}/

# list files owned by the package here
%files
/%{_bindir}/qb

%pre

%post

%preun

%postun

%posttrans

%changelog
