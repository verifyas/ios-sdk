Pod::Spec.new do |spec|
    spec.name = 'VerifyPayments'
    spec.version = '1.0.0'
    spec.license = 'MIT'
    spec.homepage = 'https://verify.as'
    spec.author = 'team@verify.as'
    spec.summary = 'VerifyPayments iOS SDK. Instant bank payments. Get paid directly to your bank account. No cards needed.'
    spec.source = { :git => 'https://github.com/verifyas/ios-sdk.git', :tag => "v#{spec.version}" }
    spec.platform = :ios, '9.0'
    spec.source_files = 'VerifyPayments/VerifyPayments/*.swift'
end
