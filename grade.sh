CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

file=`find student-submission -name "ListExamples.java"`

if [[ -f $file ]]
then
    cp -r lib grading-area
    cp -r $file grading-area
    cp -r *.java grading-area
else
    echo "Your submission file was not found. Please resubmit with the proper name: ListExamples.java"
    exit 1 
fi

cd grading-area

file=`find -name "ListExamples.java"`

javac $file 2> compile-error.txt

if [[ $? -eq 1 ]] 
then
    echo "Student file failed to compile. See errors below:"
    cat compile-error.txt
    exit 1
fi
javac -cp $CPATH TestListExamples.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > junit-test-results.txt 2> runtime-errors.txt


grep "OK" junit-test-results.txt > test-success.txt
grep -A 1 "FAILURES!!!" junit-test-results.txt > test-failure.txt
cat test-success.txt
cat test-failure.txt


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
