/**
 * @file    find_substrs.hpp
 * @version 0.0.1
 * @date    Wed, 03 Jun 2026 13:24:28 +0000
 */
#ifndef _TEST_find_substrs_H
#define _TEST_find_substrs_H

#include <cppunit/Test.h>

class TEST_find_substrs : public CppUnit::TestFixture
{
private:
    CPPUNIT_TEST_SUITE(TEST_find_substrs);
    CPPUNIT_TEST(testNoOptions);
    CPPUNIT_TEST(testOptionHelp);
    CPPUNIT_TEST(testOptionHelpLong);
    CPPUNIT_TEST(testOptionVerbose);
    CPPUNIT_TEST(testOptionVerboseLong);
    CPPUNIT_TEST_SUITE_END();

public:
    void setUp();
    void tearDown();

    // agregate test functions
    void execute();
    void execute(int argc, char* argv[]);

protected:
    void testNoOptions();
    void testOptionHelp();
    void testOptionHelpLong();
    void testOptionVerbose();
    void testOptionVerboseLong();

private:
    int m_argc;
    char* m_argv[10];

};

#endif
